package merb_upload
{
    import upload.UploadProgressComponent

    import mx.core.WindowedApplication;
    import mx.containers.VBox;
    import mx.controls.Button;

    import mx.events.FlexEvent;
    import flash.events.*;

    import flash.desktop.*;
    import flash.filesystem.File;
    import flash.net.*;

    public class App extends WindowedApplication
    {
        private var filesToUpload :Array
        private var UploadProgressComponents :Array;
        public var files_vb:VBox;
        public var upload_btn:Button;
        private var uploadURL:URLRequest;

        /*
         * Constructor
         */
        public function App() :void
        {
            addEventListener( FlexEvent.CREATION_COMPLETE, creationCompleteHandler );
        }

        /*
         * creationComplete
         *
         * called when the AIR has finishe loading, sets up drag/drop event listeners reference objects
         *
         */
        private function creationCompleteHandler( event:FlexEvent ) :void
        {
            addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER,    onDragEnter );
            addEventListener( NativeDragEvent.NATIVE_DRAG_DROP,     onDragDrop );
            upload_btn.enabled = false;
            upload_btn.addEventListener( MouseEvent.CLICK, upload );

            uploadURL = new URLRequest();
            uploadURL.url = "http://localhost:4000/upload";
            uploadURL.method=URLRequestMethod.POST;

            filesToUpload = new Array();
            UploadProgressComponents = new Array();
        }

        /*
         * onDragEnter
         *
         * files have been dragged into the app
         */
        private function onDragEnter( event:NativeDragEvent ) :void
        {
           DragManager.acceptDragDrop(this);
        }

        /*
         * onDragDrop
         *
         * when files are dropped…
         */
        private function onDragDrop( event:NativeDragEvent ) :void
        {
            DragManager.dropAction = DragActions.COPY;
            var files:Array = event.transferable.dataForFormat( TransferableFormats.FILE_LIST_FORMAT ) as Array;
            for each (var f:File in files)
            {
               addFile( FileReference( f ) );
            }

            upload_btn.enabled = true;
        }

        /*
         * addFile
         *
         * …add then to filesToUpload array, and the file upload listeners,
         * and create a progress component for each file
         */
        private function addFile( f:FileReference ) :void
        {
            filesToUpload.push( f );

            var upv:UploadProgressComponent = new UploadProgressComponent();
            UploadProgressComponents.push( upv );
            files_vb.addChild( upv );
            upv.file_lb.text = f.name;
            upv.pb.source = f;

            f.addEventListener( Event.COMPLETE, completeHandler );
            f.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
        }

        /*
         * completeHandler
         *
         * a file upload is complete, remove it from filesToUpload
         * and remove the upload component
         */
        private function completeHandler( e:Event ) :void
        {
            var f:FileReference = FileReference(e.target);
            for( var i:uint; i < filesToUpload.length; i++ )
            {
                if( f.name == filesToUpload[i].name )
                {
                    files_vb.removeChild( UploadProgressComponents[i] );
                    filesToUpload.splice(i, 1);
                    UploadProgressComponents.splice(i, 1);
                }
            }
        }

        /*
         * trace any errors
         */
        private function ioErrorHandler( event:IOErrorEvent ) :void
        {
            trace("ioErrorHandler: " + event);
        }

        /*
         * upload!
         */
        private function upload( e:MouseEvent ) :void
        {
            for each (var f:File in filesToUpload)
            {
               f.upload( uploadURL );
            }
        }
    }
}
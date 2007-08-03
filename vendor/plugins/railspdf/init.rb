# Include hook code here
require "RailsPDF"
#require "ActionView"

ActionView::Base.register_template_handler 'rpdf', RailsPDF::PDFRender
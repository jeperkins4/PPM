class NotificationReceiversController < ApplicationController
  # GET /notification_receivers
  # GET /notification_receivers.json
  def index
    @notification_receivers = NotificationReceiver.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notification_receivers }
    end
  end

  # GET /notification_receivers/1
  # GET /notification_receivers/1.json
  def show
    @notification_receiver = NotificationReceiver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification_receiver }
    end
  end

  # GET /notification_receivers/new
  # GET /notification_receivers/new.json
  def new
    @notification_receiver = NotificationReceiver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification_receiver }
    end
  end

  # GET /notification_receivers/1/edit
  def edit
    @notification_receiver = NotificationReceiver.find(params[:id])
  end

  # POST /notification_receivers
  # POST /notification_receivers.json
  def create
    @notification_receiver = NotificationReceiver.new(params[:notification_receiver])

    respond_to do |format|
      if @notification_receiver.save
        format.html { redirect_to @notification_receiver, notice: 'Notification receiver was successfully created.' }
        format.json { render json: @notification_receiver, status: :created, location: @notification_receiver }
      else
        format.html { render action: "new" }
        format.json { render json: @notification_receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notification_receivers/1
  # PUT /notification_receivers/1.json
  def update
    @notification_receiver = NotificationReceiver.find(params[:id])

    respond_to do |format|
      if @notification_receiver.update_attributes(params[:notification_receiver])
        format.html { redirect_to @notification_receiver, notice: 'Notification receiver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification_receiver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_receivers/1
  # DELETE /notification_receivers/1.json
  def destroy
    @notification_receiver = NotificationReceiver.find(params[:id])
    @notification_receiver.destroy

    respond_to do |format|
      format.html { redirect_to notification_receivers_url }
      format.json { head :no_content }
    end
  end
end

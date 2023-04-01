class Api::V1::ContactsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @contacts = Contact.kept

    render json: { status: 'Success', message: 'Contact list found', data: @contacts }, status: :ok
  end

  def show
    @contact = Contact.find(params[:id])

    render json: { status: 'Success', message: 'Contact details found', data: @contact }, status: :ok
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: { status: 'Success', message: 'New contact created successfully', data: @contact }, status: :created
    else
      render json: { status: 'Failure', message: 'New contact failed to be created' }, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      render json: { status: 'Success', message: 'New contact updated successfully', data: @contact }, status: :ok
    else
      render json: { status: 'Failure', message: 'New contact failed to be updated' }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])

    @contact.discard

    render json: { status: 'Success', message: 'Contact deleted successfully' }
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email)
  end

  def record_not_found
    render json: { status: 'Failure', message: 'Record not found' }
  end
end

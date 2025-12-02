class Api::V1::PublicationsController < Api::V1::BaseController
  before_action :set_publication, only: [:show, :update, :destroy]

  def index
    @publications = @current_user.publications
    @publications = @publications.where(status: params[:status]) if params[:status].present?
    success_response(@publications, 'publications fetched successfully')
  end

  def show
    if @publication
      success_response(@publication, 'publication fetched successfully')
    else
      error_response({}, 'publication not found', :not_found)
    end
  end

  def create
    publication = @current_user.publications.build(publication_params)
    if publication.save
      success_response(publication, 'publication created successfully', :created)
    else
      error_response(publication.errors.full_messages, 'publication creation failed')
    end
  end

  def update
    if @publication&.update(publication_params)
      success_response(@publication, 'publication updated successfully')
    else
      error_response(@publication.errors.full_messages, 'publication update failed')
    end
  end

  def destroy
    if @publication&.destroy
      success_response({}, 'publication deleted successfully')
    else
      error_response({}, 'publication deletion failed')
    end
  end

  private

  def set_publication
    @publication = @current_user.publications.find_by_id(params[:id])
  end

  def publication_params
    params.require(:publication).permit(:title, :content, :status)
  end
end

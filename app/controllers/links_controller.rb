class LinksController < ApplicationController
  def delete
    @link = Link.find(params[:id])
    @link.destroy
  end
end

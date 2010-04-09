class EmailListsController < ApplicationController
  def add_to_list
    @email = EmailList.new(params[:email_list])
    respond_to do |format|
      if @email.save
        flash[:notice] = 'Gracias por enlistarte. Espera noticias.'
      end
      format.html { redirect_to "/" }
    end
  end
end

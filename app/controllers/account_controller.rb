class AccountController < ApplicationController
  before_action :authenticate_user! , except: [:unsubscribe]
  before_action :set_account
  load_and_authorize_resource class: "User"

  def show
  end

  def update
    if @account.update(account_params)
      redirect_to account_path, notice: t("flash.actions.save_changes.notice")
    else
      @account.errors.messages.delete(:organization)
      render :show
    end
  end

  def unsubscribe
    if Devise.token_generator.digest(User, :email_verification_token, User.find(params[:id]).email_verification_token) == params[:token]
      if User.find( params[:id]).update(email_on_comment: false, email_on_comment_reply: false, newsletter: false)
        redirect_to proposals_path, notice: t("flash.actions.save_changes.notice")
      else
        redirect_to proposals_path, notice: t("flash.actions.save_changes.nonotice")
      end
    end  
  end

  private

    def set_account
      @account = current_user
    end

    def account_params
      if @account.organization?
        params.require(:account).permit(:phone_number, :email_on_comment, :email_on_comment_reply, :newsletter, organization_attributes: [:name, :responsible_name])
      else
        params.require(:account).permit(:username, :public_activity, :email_on_comment, :email_on_comment_reply, :newsletter)
      end
    end

end

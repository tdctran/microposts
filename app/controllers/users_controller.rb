class UsersController < ApplicationController

  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
end

def edit
    @session_id = session[:user_id]
    if current_user == @user
      if @user.update(user_params)
        flash[success] = "プロフィールを編集しました"
      redirect_to root_path
      else
      # 保存に失敗した場合は編集画面へ戻す
      flash.now[:alert] = "プロフィールの保存に失敗しました"
      render 'edit'
      end
    else
    flash[:danger] = "正しいユーザー名でログインし直して下さい"
    redirect_to login_url
    end
end

def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'プロフィールを更新しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
end

  private

def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
end

end

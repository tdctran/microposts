class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
 
 def new
   @user = User.new
 end
 
 def create
   @user = User.new(user_params)
   if @user.save
     flash[:success] = "Welcome to the Sample App!"
     redirect_to @user # ここを修正
   else
     render 'new'
   end
 end

 def edit #自分で追加
 end
 
 def update #自分で追加
   if @user.update(user_params)
     # 保存に成功した場合はトップページへリダイレクト
     redirect_to root_path , notice: 'updated'
   else
     # 保存に失敗した場合は編集画面へ戻す
     render 'edit'
   end
 end
 
 private

 def user_params
   params.require(:user).permit(:name, :email, :profile, :area, :password,
                                :password_confirmation)
 end
 
 def set_user
   @user = User.find(params[:id])
 end
 
 def auth_user #自分で追加
   unless current_user == @user
     flash[:danger] = "正しいユーザーでログインしてください。"
     redirect_to login_url
   end
 end
 
end
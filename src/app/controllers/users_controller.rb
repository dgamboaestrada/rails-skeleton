class UsersController < InheritedResources::Base
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.order(params[:sort]).per_page_kaminari(params[:page]).per params[:limit]

    respond_to do |format|
      format.json { render json: @users }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @user }
    end
  end

  def create
    @user = User.create(
      email: user_params[:email],
      password: user_params[:password],
    )
    respond_to do |format|
      if @user.valid?
        format.json { render :show, status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.update(user_params)
    respond_to do |format|
      if @user.valid?
        format.json { render json: @user, status: :ok, location: @user  }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

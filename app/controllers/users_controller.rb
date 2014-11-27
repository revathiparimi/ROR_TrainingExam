class UsersController < ApplicationController
	 #skip_before_filter :verify_authenticity_token, :only => [:destroy, :create,:update]
	def index
		@users=User.all
		
	end

	def new
		@user=User.new
	end

	#http://localhost:3000/users?user[firstname]=revathi&user[lastname]=parimi      method:POST
	def create
		@user=User.new(user_params)
		 if @user.save
		 	redirect_to "/users/show"
    	 else
      		render("new")
    	 end
	end

	#http://localhost:3000/users/show.json  method:GET
	def show
		@users=User.all
		respond_to do |format|
      		format.html
      		format.json { render json: @users }
    	end
	end

	#http://localhost:3000/users/1?user[firstname]=creatives  method:PUT
	def update
		@user=User.find(params[:id])
        @user.update(user_params)

        if @user.save
          redirect_to "/users/show"
        end
	end

	def edit
	end

	#http://localhost:3000/users/1  method:DELETE
	def destroy
		@user=User.find(params[:id])
		@user.delete
		redirect_to "/users/show"
		
	end

	private
	def user_params
		params.require(:user).permit(:firstname, :lastname)

	end

end

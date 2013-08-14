class GoalsController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create]

	def index
		@goals = Goal.all
	end

	def show
		@goal = Goal.find params[:id]
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = Goal.new safe_goal_params
		@goal.user = current_user
		if @goal.save
			redirect_to @goal
		else
			render :new
		end
	end

	def edit
		@goal = current_user.goals.find(params[:id])
	end

	def update
		@goal = current_user.goals.find(params[:id])

		if @goal.update_attributes(safe_goal_params)
			redirect_to goals_path
		else
			render :edit
		end

	end

	def destroy
		goal = current_user.goals.find(params[:id])
		goal.destroy

		redirect_to goals_path
	end


	private

	def safe_goal_params
		params.require(:goal).permit(:title, :summary)
	end


end


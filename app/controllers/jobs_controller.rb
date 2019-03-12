class JobsController < ApplicationController
  before_action :find_job, only: [:edit, :update, :show, :destroy]
  before_action :check_permission, only:[:edit, :update, :destroy]
  def index
    @jobs = Job.all.recent
  end

  def new
    @job = Job.new
  end

  def show
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      redirect_to jobs_path
      flash[:success] = '发布招聘信息成功'
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path
      flash[:success] = '更新招聘信息成功'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
    flash[:success] = '删除招聘信息成功'
  end

  private

  def find_job
    @job = Job.find(params[:id])
  end
  def job_params
    params.require(:job).permit(:title, :description)
  end

  def check_permission
    if current_user != @job.user
      redirect_to root_path
      flash[:danger] = '您没有权限'
    end
  end
end

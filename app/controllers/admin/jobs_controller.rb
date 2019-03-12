class Admin::JobsController < ApplicationController
  before_action :find_job, only:[:shwo, :edit, :update, :destroy]
  before_action :require_is_admin
  def index
    @jobs = Job.all.recent
  end

  def show
  end

  def new
    @job = Job.new
  end

  def edit

  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      redirect_to admin_jobs_path
      flash[:success] = '招聘信息发布成功'
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path
      flash[:success] = '招聘信息更新成功'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to admin_jobs_path
    flash[:success] = '招聘信息删除成功'
  end

  private
  def find_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description)
  end



end

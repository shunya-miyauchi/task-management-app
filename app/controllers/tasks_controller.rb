class TasksController < ApplicationController
  before_action :set_task , only: [:show,:edit,:update,:destroy]

  # 一覧
  def index
    @tasks = Task.all.create_latest
    if params[:search].present?
      params_title = params[:search][:title]
      params_status = params[:search][:status]
      if (params_title && params_status).present?
        @tasks = Task.title_search(params_title).status_search(params_status)
      elsif params_title.present?
        @tasks = Task.title_search(params_title)
      elsif params_status.present?
        @tasks = Task.status_search(params_status)
      end
    elsif params[:sort_expired]
      @tasks = Task.all.expired_latest
    end
  end

  # 詳細
  def show
  end

  # 新規作成
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスク追加"
      redirect_to tasks_path
    else
      render :new
    end
  end

  # 編集
  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "編集しました"
      redirect_to tasks_path
    else 
      render :edit
    end
  end

  # 削除
  def destroy
    @task.destroy
    flash[:notice] = "削除しました"
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title,:detail,:expired_at,:status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end

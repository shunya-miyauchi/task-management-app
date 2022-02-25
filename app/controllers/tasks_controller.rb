class TasksController < ApplicationController
  before_action :set_task , only: [:show,:edit,:update,:destroy]

  # 一覧
  def index
    @tasks = Task.all.page(params[:page]).per(5).create_latest
    if params[:search].present?
      params_title = params[:search][:title]
      params_status = params[:search][:status]
      if (params_title && params_status).present?
        @tasks = Task.page(params[:page]).per(5).title_search(params_title).status_search(params_status)
      elsif params_title.present?
        @tasks = Task.page(params[:page]).per(5).title_search(params_title)
      elsif params_status.present?
        @tasks = Task.page(params[:page]).per(5).status_search(params_status)
      end
    elsif params[:sort_expired]
      @tasks = Task.all.page(params[:page]).per(5).expired_latest
    elsif params[:sort_priority]
      @tasks = Task.all.page(params[:page]).per(5).order(priority: "ASC")
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
    params.require(:task).permit(:title,:detail,:expired_at,:status,:priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end


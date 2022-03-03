class TasksController < ApplicationController
  before_action :set_task , only: [:show,:edit,:update,:destroy]

  # 一覧
  def index
    tasks = current_user.tasks
    @tasks = tasks.all.create_latest.page(params[:page]).per(5)
    if params[:search].present?
      params_title = params[:search][:title]
      params_status = params[:search][:status]
      params_label = params[:search][:label]
      if params_title.presence && params_status.presence && params_label.presence
        @tasks = tasks.title_search(params_title).status_search(params_status).label_search(params_label).page(params[:page]).per(5)
      elsif params_title.presence && params_label.presence
        @tasks = tasks.title_search(params_title).label_search(params_label).page(params[:page]).per(5)
      elsif params_status.presence && params_label.presence
        @tasks = tasks.status_search(params_status).label_search(params_label).page(params[:page]).per(5)
      elsif params_title.presence && params_status.presence
        @tasks = tasks.title_search(params_title).status_search(params_status).page(params[:page]).per(5)
      elsif params_title.present?
        @tasks = tasks.title_search(params_title).page(params[:page]).per(5)
      elsif params_status.present?
        @tasks = tasks.status_search(params_status).page(params[:page]).per(5)
      elsif params_label.present?
        @tasks = tasks.label_search(params_label).page(params[:page]).per(5)
      end 
    elsif params[:sort_expired]
      @tasks = tasks.all.expired_latest.page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = tasks.all.order(priority: "ASC").page(params[:page]).per(5)
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
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title,:detail,:expired_at,:status,:priority,label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end

end


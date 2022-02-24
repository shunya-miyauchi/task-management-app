class TasksController < ApplicationController
  before_action :set_task , only: [:show,:edit,:update,:destroy]

  # 一覧
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: "DESC")
    else
      @tasks = Task.all.order(created_at: "DESC")
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

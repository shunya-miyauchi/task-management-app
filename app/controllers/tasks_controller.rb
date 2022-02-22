class TasksController < ApplicationController

  # 一覧
  def index
    @tasks = Task.all
  end

  # 詳細
  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "編集しました"
      redirect_to tasks_path
    else 
      render :edit
    end
  end

  # 削除
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "削除しました"
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name,:detail)
  end

end

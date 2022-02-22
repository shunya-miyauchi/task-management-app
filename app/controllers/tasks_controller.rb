class TasksController < ApplicationController

  # 一覧
  def index
    @tasks = Task.all
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
  end

  # 削除
  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name,:detail)
  end

end

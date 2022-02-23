require 'rails_helper'

RSpec.describe "タスク管理機能",type: :system do
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in "タスク名",with: "課題"
        fill_in "詳細",with: "今日終わらせる"
        click_on "追加"
        expect(page).to have_content "今日"
      end      
    end        
  end
  describe "一覧表示機能" do
    let!(:task) { FactoryBot.create(:task) }
    let!(:task_second) { FactoryBot.create(:task,title:"課題",detail:"終わらせたい") }
    before do
      visit tasks_path
    end
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        expect(page).to have_content "test_title"
      end
    end
    context "タスクが作成日時の降順に並んでいる場合" do
      it "新しいタスクが一番上に表示される" do
        task_list = all(".task_list")
        expect(task_list[0]).to have_content "課題"
      end
    end
  end
  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        FactoryBot.create(:task,title:"task")
        visit tasks_path
        click_on "詳細"
        expect(page).to have_content "task"
      end
    end        
  end
end
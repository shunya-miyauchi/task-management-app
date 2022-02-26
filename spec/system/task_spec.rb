require 'rails_helper'

RSpec.describe "タスク管理機能",type: :system do
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in "task[title]",with: "課題"
        fill_in "task[detail]",with: "今日終わらせる"
        select "着手中", from: "task[status]"
        fill_in "task[expired_at]",with: Time.current
        click_on "追加"
        expect(page).to have_content "着手中"
      end      
    end        
  end

  describe "一覧表示機能" do
    let!(:task){ FactoryBot.create(:task) }
    let!(:task_second){ FactoryBot.create(:task_second) }
    let!(:task_third){FactoryBot.create(:task_third) }
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
        task_title = page.all(".task_title")
        expect(task_title[0]).to have_content "課題"
      end
    end
  end

  describe "ソート機能" do
    let!(:task){ FactoryBot.create(:task) }
    let!(:task_second){ FactoryBot.create(:task_second) }
    let!(:task_third){FactoryBot.create(:task_third) }
    before do
      visit tasks_path
    end
    context "終了期限でソートするというリンクを押した場合" do
      it "終了期限が遅いタスクが一番上に表示される" do
        click_button "dropdownMenuButton"
        click_link "終了期限"
        sleep 1
        expect(all(".task_title")[0]).to have_content "今日"
        expect(all(".task_title")[1]).to have_content "課題"
      end
    end
    context "優先順位でソートするというリンクを押した場合" do
      it "優先順が高いタスクが一番上に表示される" do
        click_button "dropdownMenuButton"
        click_link "優先順"
        sleep 1
        expect(all(".task_priority")[0]).to have_content "高"
        expect(all(".task_priority")[2]).to have_content "低"
      end
    end
  end
  describe "検索機能" do
    let!(:task){ FactoryBot.create(:task) }
    let!(:task_second){ FactoryBot.create(:task_second) }
    let!(:task_third){FactoryBot.create(:task_third) }
    before do
      visit tasks_path
    end
    context "タスク名であいまい検索をした場合" do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in "タスク名検索",with: "今日"
        click_on "検索"
        expect(page).to have_content "今日"
        expect(page).to_not have_content "課題"
      end
    end
    context "ステータス検索をした場合" do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select "着手中", from: "search[status]"
        click_on "検索"
        expect(page).to have_selector "td",text: "着手中"
      end
    end
    context "タイトルのあいまい検索とステータス検索をした場合" do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in "タスク名検索",with: "今日"
        select "着手中", from: "search[status]"
        click_on "検索"
        expect(page).to have_content "いい天気"
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
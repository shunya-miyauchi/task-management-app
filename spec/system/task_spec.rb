require 'rails_helper'

RSpec.describe "タスク管理機能",type: :system do
  let!(:user){ FactoryBot.create(:user) }
  let!(:task){ FactoryBot.create(:task,user: user) }
  let!(:task_second){ FactoryBot.create(:task_second,user: user) }
  let!(:task_third){FactoryBot.create(:task_third,user: user) }
  before do
    visit new_session_path
    fill_in "session[email]",with: "aaa@gmail.com"
    fill_in "session[password]",with: "123456"
    click_on "ログイン"    
  end

  describe "新規投稿機能" do
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
      it "ラベルの付与ができる" do
        visit new_task_path
        fill_in "task[title]",with: "課題"
        fill_in "task[detail]",with: "今日終わらせる"
        select "着手中", from: "task[status]"
        fill_in "task[expired_at]",with: Time.current
        check "ラベル１"
        click_on "追加"
        expect(all("tbody tr")[0]).to have_content "着手中"
        expect(all("tbody tr")[0]).to have_content "ラベル１"
      end      
    end
  end

  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        all("tbody tr")[0].click_on "詳細"
        expect(page).to have_content "終わらせたい"
      end
      it "該当タスクのラベル一覧を表示する" do
        all("tbody tr")[0].click_on "詳細"
        expect(page).to have_content "ラベル３"
      end
    end        
  end


  describe "一覧表示機能" do
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
    context "ラベル検索をした場合" do
      it "ラベルに一致するタスクが絞り込まれる" do
        select "ラベル１", from: "search[label]"
        click_on "検索"
        expect(page).to have_selector "td",text: "ラベル１"
        expect(page).not_to have_selector "td",text: "ラベル２"
      end
    end
  end
end
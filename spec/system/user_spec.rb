require 'rails_helper'

RSpec.describe "ユーザー管理",type: :system do
  describe "ユーザー登録機能" do
    context "新規登録した場合" do
      it "タスク一覧画面に遷移する" do
        visit new_user_path
        fill_in "user[name]",with: "みやうち"
        fill_in "user[email]",with: "aaa@gmail.com"
        fill_in "user[password]",with: "123456"
        fill_in "user[password_confirmation]",with: "123456"        
        expect{click_on "新規作成"}.to change {current_path}.from(new_user_path).to(tasks_path)
      end
      it "ログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移する" do
        expect(visit tasks_path).to be visit new_user_path
      end  
    end      
  end

  describe "ログイン機能" do
    let!(:user){ FactoryBot.create(:user) }
    let!(:user_second){ FactoryBot.create(:user_second) }
    let!(:task){ FactoryBot.create(:task,user: user) }
    before do
      visit new_session_path
      fill_in "session[email]",with: "aaa@gmail.com"
      fill_in "session[password]",with: "123456"
      click_on "ログイン"
    end
    context "ログインした場合" do
      it "タスク一覧画面に遷移する" do
        expect(current_path).to eq tasks_path
      end
      it "マイページに遷移する" do
        click_on "Profile"
        expect(page).to have_content "ユーザー詳細"
      end
      it "他人のマイページに飛ぼうとしたとき、タスク一覧画面に遷移する" do
        visit user_path(user_second.id)
        expect(current_path).to eq tasks_path
      end
    end
    context "ログアウトした場合" do
      it "ログイン画面に遷移する" do
        click_on "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "管理ユーザー機能" do
    let!(:user){ FactoryBot.create(:user) }
    let!(:user_second){ FactoryBot.create(:user_second) }
    let!(:task){ FactoryBot.create(:task,user: user) }
    context "管理ユーザーの場合" do
      before do
        visit new_session_path
        fill_in "session[email]",with: "aaa@gmail.com"
        fill_in "session[password]",with: "123456"
        click_on "ログイン"
        click_on "管理者画面"
        sleep 0.5
      end
      it "管理画面に遷移できる" do
        expect(current_path).to eq admin_users_path
        expect(page).to have_content "ユーザー管理" 
      end
      it "ユーザーの新規登録ができる" do
        click_on "新規ユーザー"
        fill_in "user[name]",with: "やまもと"
        fill_in "user[email]",with: "ccc@gmail.com"
        fill_in "user[password]",with: "123456"
        fill_in "user[password_confirmation]",with: "123456"
        click_on "新規作成"
        expect(page).to have_content "やまもと"  
      end
      it "ユーザの詳細画面に遷移できる" do
        all("tbody tr")[0].click_on "詳細"
        expect(page).to have_content "みやうち"
      end
      it "ユーザの編集画面からユーザを編集できる" do
        all("tbody tr")[0].click_on "編集"
        fill_in "user[name]",with: "やまもと"
        click_on "編集"
        expect(page).to have_content "やまもと"  
      end
      it "ユーザの削除をできる" do
        all("tbody tr")[0].click_button("削除",visible: false)
        expect(page).to have_content "削除しました" 
      end
    end
    context "一般ユーザーの場合" do
      before do
        visit new_session_path
        fill_in "session[email]",with: "bbb@gmail.com"
        fill_in "session[password]",with: "123456"
        click_on "ログイン"
      end
      it "管理画面に遷移できない" do
        click_on "管理者画面"
        expect(page).to have_content "管理者以外はアクセスできません"  
      end
    end
  end
end
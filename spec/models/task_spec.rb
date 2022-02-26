require 'rails_helper'

RSpec.describe "タスクモデル機能", type: :model do
  describe "バリデーションのテスト" do
    context "タスクのタイトルが空の場合" do
      it "バリデーションにひっかかる" do
        task = Task.new(title:"",detail:"課題")
        expect(task).not_to be_valid
      end      
    end    
    context "タスクの詳細が空の場合" do
      it "バリデーションにひっかかる" do
        task = Task.new(title:"課題",detail:"")
        expect(task).not_to be_valid   
      end      
    end
    context "タスクのタイトルと詳細に内容が記載されている場合" do
      it "バリデーションが通る" do
        task = Task.new(title:"課題",detail:"今日中に終わらせる")
        expect(task).to be_valid  
      end
    end     
  end

  describe "検索機能" do
      let!(:task){ FactoryBot.create(:task) }
      let!(:task_second){ FactoryBot.create(:task_second) }
      let!(:task_third){FactoryBot.create(:task_third) }
    context "scopeメソッドでタイトルのあいまい検索をした場合" do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search("test_title")).to include(task)
        expect(Task.title_search("test_title")).not_to include(task_second)
        expect(Task.title_search('test_title').count).to eq 1
      end
    end
    context "scopeメソッドでステータス検索をした場合" do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search("未着手")).to include(task)
        expect(Task.status_search("未着手")).not_to include(task_second)
        expect(Task.status_search('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_search("test_title").status_search("未着手")).to include(task)
        expect(Task.title_search("test_title").status_search("未着手")).not_to include(task_second)
        expect(Task.title_search("test_title").status_search("未着手").count).to eq 1
      end
    end

    
    



    
  end
  


end

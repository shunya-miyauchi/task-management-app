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
end

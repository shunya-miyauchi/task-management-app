class Task < ApplicationRecord
  validates :title,presence: true;
  validates :detail,presence: true;

  enum status: {未着手:"未着手",着手中:"着手中",完了:"完了"}
  enum priority: { 高:0,中:1,低:2}

  scope :create_latest, -> { order(created_at: "DESC") }
  scope :status_search, -> (params_status){ where(status: params_status) }
  scope :title_search, -> (params_title){ where("title like ?","%#{params_title}%")}
  scope :expired_latest, -> { order(expired_at: "DESC") }

  belongs_to :user
end
module ChangeHistory
  extend ActiveSupport::Concern

  included do
    before_update :capture_history
  end

  def capture_history
    self.changes.each do |attribute_name, values|
      next if attribute_name == "updated_at"
      before_value = values[0].to_s
      after_value = values[1].to_s
      
        History.create!({
          object_name: self.class.name,
          object_id: id,
          attribute_name: attribute_name,
          before_value: before_value.to_s,
          after_value: after_value.to_s})
      
    end
  end
end
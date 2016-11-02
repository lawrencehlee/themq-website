class Position < ActiveRecord::Base
  STAFF_WRITER_ID = 20

  def is_editor?
    self.position_id != STAFF_WRITER_ID
  end
end

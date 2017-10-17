module SubjectsHelper
  def subject_column_for_suppervisor
    Subject.column_names - %w(id created_at updated_at) + %w(action)
  end
end

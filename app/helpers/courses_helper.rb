module CoursesHelper
  def check_status course
    case true
    when course.init?
      @status = t ("public.init")
    when course.in_progress?
      @status = t ("public.in_progress")
    else
      @status = t ("public.finish")
    end
    @class = "label-status status-#{@status}"
  end

  def status_hash
    @status_hash = {init: t("courses._status.init"),
      in_progress: t("courses._status.in_progress"),
      finish: t("courses._status.finish")}
  end
end

module AddLabelsHelper
  def add_labels(task, label)
    visit edit_task_path(task)
    check label
    click_on 'finish'
  end
end

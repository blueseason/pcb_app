# This is for a field which occupied a single row and label is in stacked mode
SimpleForm.setup do |config|
  config.wrappers :etable, :tag => "tr", :error_class => "error" do |b|
    b.use :tag => "th" do |td|
      td.use :label
    end

    b.use :tag => "td" do |td|
      td.use :input
      td.use :error
      td.use :hint
    end
  end
end

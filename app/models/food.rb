class Food
  attr_reader :ndbno, :name, :group, :data_source, :manufacturer
  def initialize(info)
    @ndbno = info[:ndbno]
    @name = info[:name]
    @group = info[:group]
    @data_source = info[:ds]
    @manufacturer = info[:manu]
  end
end

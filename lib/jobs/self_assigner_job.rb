class SelfAssignerJob
  @queue = :registration

  def self.perform
    executions = Registration.where(:user_id => nil).reduce([]) do |acc, r|
      puts "registration without execution : #{r.inspect}" and next unless r.execution
      if r.execution.quantity == 1
        r.user = r.execution.user
        r.save!
        puts "assigning to #{r.user.email}"
      else
         acc << r.execution unless acc.include?(r.execution)
      end
      acc
    end
    executions.reduce(0) do |acc, e|
      puts "#{e.quantity} #{e.product.ref} to assign for #{e.user.email}"
      acc += e.quantity
    end
  end
end
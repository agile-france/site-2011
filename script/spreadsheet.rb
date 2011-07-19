# encoding: utf-8
class Spreadsheet
  def info(user)
    [user.last_name, user.first_name, user.email, user.company ? user.company.name : ""]
  end

  def payer?(u, registrations)
    payers = registrations.map {|r| r.execution.user}.uniq
    payers == [u] ? "Payer!" : payers.map{|p| "#{p.greeter_name} [#{p.email}]"}
  end

  def products(products, registrations)
    products.map {|p| registrations.any? {|r| r.product == p} ? "X" : ""}
  end

  def invoices(u)
    u.invoices.empty? ? "" : u.invoices.map {|i| i.ref}
  end

  def dump(filename='spreadsheet.csv')
    File.open(filename, 'w') {|f| f << self.assigned.map{|l| l.join(";")}.join($/)}
  end

  def assigned
    headers = %w(Name FirstName Email Entreprise Payer Invoices Place Diner)
    registrations_per_user = Registration.assigned.group_by {|r| r.user}
    products = Product.all.sort {|a,b| b.ref <=> a.ref}

    registrations_per_user.reduce([headers]) do |acc, (user, registrations)|
      acc << [info(user), payer?(user, registrations), invoices(user), products(products, registrations)].flatten
      acc
    end
  end
end





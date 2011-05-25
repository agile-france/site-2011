clean manuel
============

### Products
    ruby-1.9.2-p136 :014 > Product.all.to_a
     => [
     #<Product _id: 4d99b79c4ff6f714c4000002, _type: nil, _id: BSON::ObjectId('4d99b79c4ff6f714c4000002'), conference_id: "agile-france-2011", ref: "place", description: nil>,
     #<Product _id: 4d99b79c4ff6f714c4000003, _type: nil, _id: BSON::ObjectId('4d99b79c4ff6f714c4000003'), conference_id: "agile-france-2011", ref: "diner", description: nil>]



inscription free
----------------
  pascal pratmarty
  loic midy

=>

  ['4d8facd64ff6f75266000a94', '4d9c5d4a4ff6f706fb00022d'].each do |k|
    User.find(k).executions.each do |e|
      Execution.update!(e, 0)
    end
  end


14 places et 1 diner a supprimer
--------------------------------

  ['4daf043d4ff6f7664d000c70'].each do |k|
    jr = User.find(k)
    jr.executions.where(product_id: '4d99b79c4ff6f714c4000002')[0..1].each(&:destroy)
    jr.executions.where(product_id: '4d99b79c4ff6f714c4000003').destroy_all
  end


tasks
-----

    rake jobs:clean_orphans
    rake jobs:assign_self jobs:invoice

background jobs
---------------

    QUEUE=* rake resque:work

tip: retry all failed jobs [resque-how-to-requeue-failed-jobs](http://ariejan.net/2010/08/23/resque-how-to-requeue-failed-jobs/)

    (Resque::Failure.count-1).downto(0).each { |i| Resque::Failure.requeue(i) }
    Resque::Failure.clear

Coherence
=========
    ruby-1.9.2-p136 :030 > Execution.where(side: 'B').reduce(0) {|acc, e| acc += e.quantity; acc}
     => 204
    ruby-1.9.2-p136 :031 > Registration.count
     => 204

    Execution.where(side: 'B', product_id: Product.where(ref: 'place').first.id).group_by{|e| e.price}.map{|price, executions| [price, executions.reduce(0) {|acc, e| acc += e.quantity}] }

INRA
----
    people = File.read('inra.txt').split($/).map{|s| s.split}.map{|first, last|
      login="#{first[0]}#{last}".downcase
      User.create! first_name: first, last_name: last, email: "#{login}@versailles.inra.fr", password: 'git rocks', password_confirmation: 'git rocks'
    }

    oi = User.identified_by_email /oinizan/
    vd = User.identified_by_email /dorothee.valdenaire@versailles.inra.fr/

    inras = [people, oi, vd].flatten

    places = oi.executions.first.registrations

    13.times {|i| places[i].tap{|p| p.user = inras[i]}.save}

Sending late emails
-------------------
    (27..31).map {|i| "INV-11%02d" % i}.map {|ref| InvoiceMailerJob.perform Invoice.where(ref: ref).first.id.to_s}


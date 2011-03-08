# fabrication steps as, of 0.9.4 support exactly 2 columns, which looks weird ... why ?
# more the less a step like this one will fail to go through 2 levels of nesting
# Conference embeds Product => Product.last is ... always nil ..

# Given /^the latest "([^"]*)" has the following "([^"]*)":$/ do |parent, child, table|
#   document = eval("parent.classify.constantize.last")
#   table.hashes.each do |hash|
#     document.send(child.to_sym).build(hash.symbolize_keys)
#   end
#   document.save
#   document
# end

# hence, I leave this for a while, not too long, so that I have a chance of transforming this into knownledge (tracker or whatever)
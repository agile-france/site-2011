module ScopedDatabaseAccess
  def touch_db_with(symbol, scope = :all, &block)
    attr_accessor symbol
    before(scope) {send("#{symbol}=", instance_eval(&block))}
    after(scope) {send(symbol).tap {|o| o.destroy if o.respond_to?(:destroy)}}
  end
end
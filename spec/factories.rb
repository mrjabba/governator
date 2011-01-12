Factory.define :appgroup do |appgroup|
  appgroup.name                  "group A"
end

Factory.define :app do |app|
  app.name                  "app A"
  app.appgroup { |appgroup|  appgroup.association(:appgroup) }
end

Factory.define :resource do |resource|
  resource.name                  "resource A"
end

Factory.define :role do |role|
  role.name                  "role A"
  role.description                  "role A description"
end

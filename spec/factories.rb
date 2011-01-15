Factory.define :appgroup do |appgroup|
  appgroup.id        1
  appgroup.name                  "group A"
end

Factory.define :app do |app|
  app.id        2
  app.name                  "app A"
  app.appgroup { |appgroup|  appgroup.association(:appgroup) }
end

Factory.define :resource do |resource|
  resource.name                  "resource A"
  resource.app { |app|  app.association(:app) }
end

Factory.define :role do |role|
  role.name                  "role A"
  role.description                  "role A description"
  role.app { |app|  app.association(:app) }
end

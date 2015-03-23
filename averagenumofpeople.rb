f=File.open("statisticslabdata.csv","r")
data=f.read
f.close

data_points=data.split("\r")

sum=0
data_points.each do |data_point|
  data_values=data_point.split(',')
  data_value=data_values[19].to_f
  sum=sum+data_value
end
avg=sum/data_points.count
n=0
data_points.each do |data_point|
  data_values=data_point.split(',')
  data_value=data_values[19].to_f
  n=n+(data_value-avg)**2
end
stand_dev=(n/data_points.count)**0.5

new_data_points=[]
data_points.each do |data_point|
  data_values=data_point.split(',')
  data_value=data_values[19].to_f
  z_score=(data_value-avg)/stand_dev
  z_score=z_score.to_s
  new_data_points.push(data_point+","+z_score)
end

f=File.new("new_data_points.csv","w")
f.write(new_data_points.join("\n"))
f.close
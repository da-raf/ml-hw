%% Read in Dataset
data = csvread('homework03.csv');
%remove first line (Remove labels)
data = data(2:end,:);
coords = data(:,1:3)
labels = data(:,4)

xa = [4.1, -0.1, 2.2]
xb = [6.1, 0.4, 1.3]


%% Since the axis are not equaly derivated we have to do some standardization

%% Doing the Standardization   
  xaStd(1) = (xa(1) - mean(coords(:,1)))./std(coords(:,1)); 
  xaStd(2) = (xa(2) - mean(coords(:,2)))./std(coords(:,2));
  xaStd(3) = (xa(3) - mean(coords(:,3)))./std(coords(:,3));
  
  xbStd(1) = (xb(1) - mean(coords(:,1)))./std(coords(:,1)); 
  xbStd(2) = (xb(2) - mean(coords(:,2)))./std(coords(:,2));
  xbStd(3) = (xb(3) - mean(coords(:,3)))./std(coords(:,3));
  
  coordsStd(:,1) = (coords(:,1) - mean(coords(:,1)))./std(coords(:,1));
  coordsStd(:,2) = (coords(:,2) - mean(coords(:,2)))./std(coords(:,2));
  coordsStd(:,3) = (coords(:,3) - mean(coords(:,3)))./std(coords(:,3));
%%LOOCV Tests 
%Without Standardization
for valid = 1:size(labels,1)
  dist =[];
  x = data(valid,1:3);
  for i = 1:size(labels,1)
    %Calculating the dist to each point  
    dist = [norm(coords(i)-x),dist];
  end
  [~,i] = sort(dist);
  %Since Training data are unique we get the 3 NN to Validation Point by taking the 3 Closest point with dist ~= 0 (i(1)= valid) 
  % the second part of the expression returns true iff there is a tie 
  out(valid) = (mode(labels(i(2:4))) == labels(valid)) || size(unique(labels(i(2:4))),2) == 3;
 end

 %With Standardization
 for valid = 1:size(labels,1)
  dist =[];
  x = coords(valid,1:3);
  for i = 1:size(labels,1) 
    dist = [norm(coordsStd(i,:)-x),dist];
  end
  [~,i] = sort(dist);
  outStd(valid) = (mode(labels(i(2:4))) == labels(valid)) || size(unique(labels(i(2:4))),2) == 3;
 end

 %%%LOOCV Results
 
 quality = mean(out)
 
 qualityStd = mean(outStd)
 
%% Labeling the Points
%Classification without Standardization
for i = 1:size(labels,1) 
  dist(i) = norm(coords(i,:)-xa);
end
[~,i] = sort(dist);
va = mode(data(i(1:3),4))

for i = 1:size(labels,1) 
  dist(i) = norm(coords(i,:)-xb);
end

[~,index] = sort(dist);
vb = mode(data(index(1:3),4))


 
%Classification with Standardization 
for i = 1:size(labels,1) 
  dist(i) = norm(coordsStd(i,:)-xaStd);
end

[~,i] = sort(dist);
vaStandardized = mode(labels(i(1:3)))

for i = 1:size(labels,1) 
  dist(i) = norm(coordsStd(i,:)-xbStd);
end

[~,i] = sort(dist);
vbStandardized = mode(labels(i(1:3)))


%% Regession (just using standardization)

for i = 1:size(labels,1) 
  dist(i) = norm(coordsStd(i,:)-xaStd);
end

[~,i] = sort(dist);
vareg = (1/sum(1./dist(i(1:3)))) * sum ( 1./(dist(i(1:3))) * labels(i(1:3)))

for i = 1:size(labels,1) 
  dist(i) = norm(coordsStd(i,1:3)-xbStd);
end

[~,i] = sort(dist);
vbreg = (1/sum(1./dist(i(1:3)))) * sum ( 1./(dist(i(1:3))) * labels(i(1:3)))
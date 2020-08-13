function F = myfun(x,xdata)
  F = x(1)+x(2)*xdata(:,1)+x(3)*xdata(:,1).^2+x(4)*xdata(:,2)+x(5)*xdata(:,2).^2;
end


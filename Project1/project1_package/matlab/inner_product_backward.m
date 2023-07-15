function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

% Replace the following lines with your implementation.

input_od = param.w*output.diff;


param_grad.b  = transpose(output.diff*ones(size(output.diff,2),1));

param_grad.w = input.data*transpose(output.diff);


end

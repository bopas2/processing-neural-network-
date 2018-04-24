class brain {

  int input = 0;
  int hidden = 0;
  int output = 0;

  Matrix a2;

  float learningRate = .01;
  float lambda = .01; 

  Matrix Theta1;
  Matrix Theta2;

  brain(int input, int hidden, int output) {
    this.input = input;
    this.hidden = hidden;
    this.output = output;
    Theta1 = new Matrix(input, hidden, true);
    Theta2 = new Matrix(hidden, output, true);
  }

  Matrix feedForward(Matrix input) {
    Matrix inner = input.multiply(input,Theta1);
    float[] tempdat = new float[inner.collumns];
    for(int i = 0; i < inner.collumns; i++) {
      for(int j = 0; j < inner.rows; j++) {
        tempdat[i] += inner.data[j][i];
      }
      tempdat[i] = sigmoid(tempdat[i]);
    }
    
    inner = new Matrix(1,inner.collumns,tempdat);
    this.a2=inner;
    inner.addBias();
    Matrix output = inner.multiply(inner,Theta2);

    float[] tempdatOut = new float[output.collumns];
    for(int i = 0; i < output.collumns; i++) {
      for(int j = 0; j < output.rows; j++) {
        tempdatOut[i] += output.data[j][i];
      }
      tempdatOut[i] = sigmoid(tempdatOut[i]);
    }
    output = new Matrix(1,output.collumns,tempdatOut);
       
    return output;
  }
  
  Matrix[] calcGradient(Matrix input, Matrix actual) {
    Matrix guess = feedForward(input);
    Matrix Theta1Grad = new Matrix(this.Theta1.rows,this.Theta1.collumns,false);
    Matrix Theta2Grad = new Matrix(this.Theta2.rows,this.Theta2.collumns,false);
    Matrix cost3 = guess.subtract(guess,actual);
    Matrix cost2 = cost3.multiply(cost3,Theta2.transpose());
    cost2 = cost2.dotMultiply(cost2,sigmoidGrad(this.a2));
    cost2.removeBias();
    
    Theta1Grad = Theta1Grad.add(Theta1Grad, cost2.multiply(input.transpose(),cost2));
    Theta2Grad = Theta2Grad.add(Theta2Grad, cost3.multiply(input.transpose(),cost3));
    Theta1Grad = Theta1Grad.add(Theta1Grad, Theta1.multiply(lambda)); 
    Theta2Grad = Theta2Grad.add(Theta2Grad, Theta2.multiply(lambda));
    
    Matrix[] gradients = {Theta1Grad,Theta2Grad};
    return gradients;
  }
  
  float sigmoid(float input) {
    return 1.0/(1.0 + exp(-1 * input));
  }
  
  Matrix sigmoidGrad(Matrix input) {
    Matrix ans = new Matrix(input.rows,input.collumns,false);
    for(int i = 0; i < input.rows; i++) {
      for(int j = 0; j < input.collumns; j++) {
        ans.data[i][j] = sigmoid(input.data[i][j])*(1-sigmoid(input.data[i][j]));
      }
    }
    return ans;
  }
  
  void train(Matrix X, Matrix y, int iters) {
    
    for(int v = 0; v < iters; v++) {
      for(int z = 0; z < X.rows; z++) {
        Matrix input = new Matrix(1,X.collumns,false);  
        Matrix ans = new Matrix(1,y.collumns,false);
        for(int a = 0; a < X.collumns; a++) {
          input.data[0][a] = X.data[z][a];
        }
        for(int a = 0; a < y.collumns; a++) {
          ans.data[0][a] = y.data[z][a];
        }
        Matrix[] gradients = calcGradient(input,ans);
        Theta1 = Theta1.subtract(Theta1,gradients[0].multiply(learningRate));
        Theta2 = Theta2.subtract(Theta2,gradients[1].multiply(learningRate));
      }
    }
  }
  
  Matrix predict(Matrix X) { 
    Matrix guess = feedForward(X);
    for(int i = 0; i < guess.collumns; i++) {
      if(guess.data[0][i] >= .5) 
        guess.data[0][i] = 1;
      else
        guess.data[0][i] = 0;
    }
    return guess;
  }
  
}
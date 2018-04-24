class Matrix {
  
  int rows = 0;
  int collumns = 0;
  float data[][];

  //CONSTRUCTORS
  
  Matrix(int rows, int collumns, boolean randInit) {
    if(!randInit) {
      this.rows = rows;
      this.collumns = collumns;
      this.data = new float[rows][collumns];
    }
    else {
      this.rows = rows + 1; 
      this.collumns = collumns; 
      this.data = new float[this.rows][this.collumns];
      for(int i = 0; i < this.rows; i++) {
        for(int j = 0; j < this.collumns; j++) {
          float rand = (random(1) * 2 * .12 - .12);
          this.data[i][j] = rand;
        }
      }
    }
  }
  
  Matrix(int rows, int collumns, float data[]) {
    this.rows = rows;
    this.collumns = collumns;
    int counter = 0;
    this.data = new float[rows][collumns];
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < collumns; j++) {
        this.data[i][j] = data[counter];
        counter++;
      }
    }
  }
    
  void addBias() {
    float[][] newData = new float[this.rows][this.collumns+1];
    for(int i = 0; i < this.rows; i++) {
      newData[i][0] = 1.0;
    }
    for(int i = 0; i < this.rows; i++) {
      for(int j = 1; j < this.collumns+1; j++) {
        newData[i][j] = this.data[i][j-1];
      }
    }
    this.data = newData;
    this.collumns = this.collumns + 1;
  }
  
  void removeBias() {
    float[][] newData = new float[this.rows][this.collumns-1];
    for(int i = 0; i < this.rows; i++) {
      for(int j = 1; j < this.collumns; j++) {
        newData[i][j-1] = this.data[i][j];
      }
    }
    this.collumns--;
    this.data = newData;
  }
  
  
  //ADD OR SUBTRACT
  
  Matrix subtract(Matrix a, Matrix b) {
    return addOrSubtract(a,b,true);
  }
  
  Matrix add(Matrix a, Matrix b) {
    return addOrSubtract(a,b,false);
  }
  
  Matrix addOrSubtract(Matrix a, Matrix b, boolean subtract) {
    Matrix result = new Matrix(a.rows,a.collumns,false);
    for(int i = 0; i < result.rows; i++) {
      for(int j = 0; j < result.collumns; j++) {
        if(subtract)
          result.data[i][j] = a.data[i][j] - b.data[i][j];
        else 
          result.data[i][j] = a.data[i][j] + b.data[i][j];
      }
    }
    return result; 
  }
  
  //MULTIPLY
  
  Matrix multiply(Matrix a, Matrix b) {
    Matrix result = new Matrix(a.rows,b.collumns,false);
    if(a.collumns != b.rows) {
      println("collumns and row multiplcation error");
      println(a.collumns + " != " + b.rows);
      return null;
    }
    else {
      for(int i = 0; i < result.rows; i++) {
        for(int j = 0; j < result.collumns; j++) {
          float sum = 0;
          for(int k = 0; k < a.collumns; k++) {
            sum += a.data[i][k] * b.data[k][j];
          }
          result.data[i][j] = sum;
        }
      }
    }
    return result; 
  }
  
  Matrix dotMultiply(Matrix a, Matrix b) {
    Matrix result = new Matrix(a.rows,a.collumns,false);
    if(a.rows != b.rows || a.collumns != b.collumns) {
      System.out.println("dotmultiply error!");
      return null;
    }
    else {
      for(int i = 0; i < result.rows; i++) {
        for(int j = 0; j < result.collumns; j++) {
          result.data[i][j] = a.data[i][j] * b.data[i][j];
        }
      }
    }
    return result;
  }
  
  
  Matrix multiply(float n) {
    Matrix result = new Matrix(this.rows,this.collumns,false);
    for(int i = 0; i < result.rows; i++) {
      for(int j = 0; j < result.collumns; j++) {
        result.data[i][j] = n * this.data[i][j];
      }
    }
    return result;
  }
  
  //TRANSPOSE
  
  Matrix transpose() {
    Matrix result = new Matrix(this.collumns,this.rows,false);
    for(int i = 0; i < this.rows; i++) {
      for(int j = 0; j < this.collumns; j++) {
        result.data[j][i] = this.data[i][j];
      }
    }
    return result;
  }
  
  //SHOW MATRIX
  
  void display() {
    int counter = 1;
    for(int i = 0; i < this.rows; i++) {
      print("[");
      for(int j = 0; j < this.collumns; j++) {
        print(this.data[i][j]);
        if(counter %  collumns != 0) 
          print(", ");
        counter ++;
      }
      println("]");
    }
    
  }

}
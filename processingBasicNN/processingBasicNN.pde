void setup() {
  float[] dataA = new float[]{0, 0, 0, 1, 1, 0, 1, 1};
  float[] answers = new float[]{0, 1, 1, 1};
  Matrix ans = new Matrix(4, 1, answers);
  Matrix a = new Matrix(4, 2, dataA);
  a.addBias();

  brain test = new brain(2, 1, 1);

  test.train(a, ans, 2500);

  float[] guess = new float[]{0, 0};
  Matrix g = new Matrix(1, 2, guess);
  g.addBias();

  test.predict(g).display();
  
}
void draw() {
}
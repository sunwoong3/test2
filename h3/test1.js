/*문제
가로의 길이는 A cm, 세로의 길이는 B cm인 직사각형 모양의 색종이를 남김 없이 똑같은 크기의 정사각형 모양으로 자르려고 합니다. 정사각형의 크기가 가장 크려면 정사각형 한 변은 몇 cm가 되어야 하는지 구하는 함수를 작성하세요.
만약, 가로의 길이가 20 cm이고 세로의 길이가 8 cm이라고 가정했을 때, 가장 큰 정사각형의 변은 4 cm입니다.

입력
인자: A
number 타입의 A
1 <= A <= 1,000,000
인자: B
number 타입의 B
1 <= B <= 1,000,000
출력
number 타입의 정사각형 한 변의 길이를 출력해야 합니다.
입출력 예시
// 가로 20, 세로 8이 주어졌을 때, 최대 4의 길이를 가진 정사각형 타일을 가질 수 있습니다.
const output1 = test1(20, 8);
console.log(output1); // --> 4

// 가로 18, 세로 27이 주어졌을 때, 최대 9의 길이를 가진 정사각형 타일을 가질 수 있습니다.
const output2 = test1(18, 27);
console.log(output2); // --> 9 */

function test1(A, B) {
    // TODO: 여기에 코드를 작성하세요.
   //최대 공약수 구하기
    const isGcd = functsssion(a,b) {
      if(!b) {
        return a
      }
      return isGcd(b,a%b)
    } 
    return isGcd(A,B)
  }
  
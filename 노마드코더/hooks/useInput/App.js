import { useState } from "react";
import "./styles.css";


export const useInput = (initialvalue, isValid) => {
  const [value, setValue] = useState(initialvalue)
  const onChange = e => {
    const value = e.target.value
    let willUpdated = true;
    if(typeof isValid === 'function') {
      willUpdated = isValid(value)
    }
    if(willUpdated) {
      setValue(value)
    }
  } 
  return { value, onChange }
}

export default function App() {
  const validLen = (value) => value.length < 10
  const name = useInput("이름:" , validLen)
  return (
    <div className="App">
      <h1>Hello CodeSandbox</h1>
      <input {...name}/>
    </div>
  );
}

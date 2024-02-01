import { Route, Routes } from 'react-router-dom';
import './App.css';
import Login from './Components/Auth/Login';
import HomePage from './Pages/HomePage';
import PageNotFound from './Pages/PageNotFound';

function App() {
  return (
    <div style={{ padding: '0 24px' }}>
      <Routes>
          <Route path="/" element={<Login/>} />
          <Route path="/home" element={<HomePage />} />
          <Route path="*" element={<PageNotFound/>} />
        </Routes>
   
  </div>
  );
}

export default App;

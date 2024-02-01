import axios from 'axios';
import { baseUrl } from './http.common';
export default class HttpService{
      get(url) {
        return new Promise((resolve, reject) => {
            axios.get(baseUrl + url)
                .then((result) => {
                    resolve(result);
                })
                .catch((err) => {
                    reject(err);
                })
        })
    }
     post(url,data) {
        return new Promise((resolve, reject) => {
            axios.post(baseUrl + url,data)
                .then((result) => {
                    resolve(result);
                })
                .catch((err) => {
                    reject(err);
                })
        })
    }
     put(url,data) {
        return new Promise((resolve, reject) => {
            axios.put(baseUrl + url,data)
                .then((result) => {
                    resolve(result);
                })
                .catch((err) => {
                    reject(err);
                })
        })
    }
}

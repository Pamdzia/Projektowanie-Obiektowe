import React, { useEffect } from 'react';
import axios from 'axios';

const Uslugi = () => {
    useEffect(() => {
        const fetchUslugi = async () => {
            try {
                const response = await axios.get('http://localhost:3001/api/uslugi'); 
                console.log(response.data); 
            } catch (error) {
                console.error('Wystąpił błąd podczas pobierania usług', error);
            }
        };

        fetchUslugi(); 
    }, []);

    return null; 
};

export default Uslugi;

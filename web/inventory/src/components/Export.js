import * as FileSaver from "file-saver";
import XLSX from 'sheetjs-style';


const Export = ({ans,fileName}) => {
   
  
    const fileType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=UTF-8';
    const fileExtension = '.xlsx';
console.log(ans)

    const exportToExcel= async () => {

        const ws = XLSX.utils.json_to_sheet(ans);
        
        const wb= { Sheets: { 'data': ws}, SheetNames: ['data'] };
        
        const excelBuffer =XLSX.write(wb, { bookType: 'xlsx', type: 'array'});
        
        const data= new Blob ([excelBuffer], { type: fileType });
        
        FileSaver.saveAs (data, fileName+ fileExtension);
    }
    return ( 
        <>
        <button onClick={(e)=>exportToExcel(fileName)}>Excel</button>
        </>
     );
}
 
export default Export;
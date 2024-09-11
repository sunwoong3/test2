public getDayDateList(startDate, endDate, type, format) {
  const dateList = [];
  const start = dayjs(startDate);
  const end = dayjs(endDate);
  const num = end.diff(start, type);

  for (let i = 0; i <= num; i++) {
    dateList.push(dayjs(startDate).add(i, type).format(format));
  }
  return dateList;
}

public getDateList(startDate, endDate) {
  const dateList = [];
  const num = endDate - startDate;

  for (let i = 0; i <= num; i++) {
    dateList.push(Number(startDate) + i);
  }
  return dateList;
}
 
 
 public async NationDailyUvList(query) {
    const { searchStartDate, searchEndDate } = query;

    let start = searchStartDate;
    let end = searchEndDate;

    try {
      const RS = await this.NationDateSearch(
        'day',
        searchStartDate,
        searchEndDate,
      );

      if (searchStartDate === undefined && RS.length) start = RS[0].dailyUv_conDate;
      if (searchStartDate === undefined && !RS.length) start = dayjs().format('YYYY-MM-DD');
      if (searchEndDate === undefined && RS.length) end = RS[RS.length - 1].dailyUv_conDate;
      if (searchEndDate === undefined && !RS.length) end = dayjs().format('YYYY-MM-DD');

      const datesList = this.getDayDateList(start, end, 'day', 'YYYY-MM-DD');

      RS.forEach((data) => {
        data.dailyUv_conDate = dayjs(data.dailyUv_conDate).format('YYYY-MM-DD');
      });

      const nations = RS.map((el) => el.dailyUv_conCountry);
      const set = new Set(nations);
      const nationList = [...set];

      const obj = {};
      RS.forEach((item) => {
        const { dailyUv_conDate, dailyUv_conCountry, dailyUv_conCount } = item;
        if (!obj[dailyUv_conDate]) {
          obj[dailyUv_conDate] = [
            {
              nationCode: dailyUv_conCountry,
              resultCount: dailyUv_conCount,
            },
          ];
        } else {
          obj[dailyUv_conDate].push({
            nationCode: dailyUv_conCountry,
            resultCount: dailyUv_conCount,
          });
        }
      });

      datesList.forEach((date) => {
        nationList.map((nation) => {
          const check = RS.some(
            (e) =>
              e.dailyUv_conDate === date && e.dailyUv_conCountry === nation,
          );
          if (!check && !obj[date]) {
            obj[date] = [
              {
                nationCode: nation,
                resultCount: 0,
              },
            ];
          } else if (!check && obj[date]) {
            obj[date].push({
              nationCode: nation,
              resultCount: 0,
            });
          }
        });
      });

      const dateList = Object.keys(obj).sort((a, b) => {
        const date1 = dayjs(a);
        const date2 = dayjs(b);
        const num = date2.diff(date1, 'day');
        return -num;
      });

      const transformedRS = {
        result: 1,
        totalCount: RS.reduce((acc, cur) => acc + cur.dailyUv_conCount, 0),
        data: dateList.map((date) => ({
          resultDate: date,
          resultNationData: obj[date],
        })),
      };

      return transformedRS;
    } catch (error) {
      console.error(`Error occurred while fetching test with ${error.message}`);
      throw error;
    }
  }